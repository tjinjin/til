require "aws-sdk-core"

Aws.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
})

dynamodb = Aws::DynamoDB::Client.new

tableName = "Movies"

params = {
    table_name: tableName,
    projection_expression: "#yr, title, info.rating",
    filter_expression: "#yr between :start_yr and :end_yr",
    expression_attribute_names: {"#yr"=> "year"},
    expression_attribute_values: {
        ":start_yr" => 1950,
        ":end_yr" => 1959
    }
}

puts "Scanning Movies table."

begin
    loop do
        result = dynamodb.scan(params)

        result.items.each{|movie|
            puts "#{movie["year"].to_i}: " +
                "#{movie["title"]} ... " +
                "#{movie["info"]["rating"].to_f}"
        }

        break if result.last_evaluated_key.nil?

        puts "Scanning for more..."
        params[:exclusive_start_key] = result.last_evaluated_key
    end

rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to scan:"
    puts "#{error.message}"
end
