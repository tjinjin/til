// https://aws.amazon.com/jp/blogs/developer/support-for-promises-in-the-sdk/
// Check if environment supports native promises
if (typeof Promise === 'undefined') {
  AWS.config.setPromisesDependency(require('bluebird'));
}

var s3 = new AWS.S3({apiVersion: '2006-03-01', region: 'us-west-2'});
var ses = new AWS.SES({apiVersion: '2010-12-01', region: 'us-west-2'});

// Take a list of objects containing file data and send an email
var sendEmail = function sendEmail(files) {
  var keys = files.map(function(file) {
    return file.key;
  });
  var body = keys.join('n') + 'nnobjects were successfully uploaded.';
  var params = {
    Source: 'from@email.com',
    Destination: {
      ToAddresses: ['to@email.com']
    },
    Message: {
      Subject: {
        Data: 'Batch PutObject job completed'
      },
      Body: {
        Text: {
          Data: body
        }
      }
    }
  };
  return ses.sendEmail(params).promise();
};

// Upload a list of files to an S3 bucket
var putBatch = function putBatch(bucket, files) {
  // Make all the putObject calls immediately
  // Will return rejected promise if any requests fail
  return Promise.all(files.map(function(file) {
    var params = {
      Bucket: bucket,
      Key: file.key,
      Body: file.stream
    };
    return s3.putObject(params).promise();
  }));
};

// Create streams for files
var fileNames = fs.readdirSync('/path/to/dir/');
var files = fileNames.map(function(fileName) {
  return {
    key: fileName,
    stream: fs.createReadStream('/path/to/dir/' + fileName)
  };
});

//Upload directory of files to S3 bucket and send an email on success
putBatch('myBucket', files)
  .then(sendEmail.bind(null, files))
  .catch(console.error.bind(console));
