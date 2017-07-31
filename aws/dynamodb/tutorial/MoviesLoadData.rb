require "aws-sdk-core"
require "json"

Aws.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
})

dynamodb = Aws::DynamoDB::Client.new

tableName = 'Movies'

file = File.read('moviedata.json')
movies = JSON.parse(file)
movies.each{|movie|

    params = {
        table_name: tableName,
        item: movie
    }

    begin
        result = dynamodb.put_item(params)
        puts "Added movie: #{movie["year"]} #{movie["title"]}"

    rescue  Aws::DynamoDB::Errors::ServiceError => error
        puts "Unable to add movie:"
        puts "#{error.message}"
    end
}

