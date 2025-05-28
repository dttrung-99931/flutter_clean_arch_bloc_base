const succesfulLoginJson = '''
{
    "success": true,
    "statusCode": 200,
    "message": "Success",
    "data": {
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNyIsInN1YiI6IjEyMzQiLCJpYXQiOjE2NTY0Mjg3NzgsImV4cCI6MTY4Nzk2NDc3OH0.8nF5ZJ0d3Ox8Zr4u2Tz4j4bW7l9X7k9J",
        "userID": 1234,
        "cartId": 1234
    }
}
''';

const failedLoginJson = '''
{
    "success": false,
    "statusCode": 401,
    "message": "Unauthorized",
    "data": null
}
''';

const internalErrorJson = '''
{
    "success": false,
    "statusCode": 500,
    "message": "Interal server errors",
    "data": null
}
''';

const serverErrorHtml = '''
HTTP/1.1 503 Service Unavailable
Content-Type: text/html;
Content-Length: 123

<!doctype html>
<html lang="en">
<head>
  <title>503 Service Unavailable</title>
</head>
<body>
  <h1>503 Service Unavailable</h1>
  <p>The server was unable to complete your request. Please try again later.</p>
  <p>If this problem persists, please <a href="https://example.com/support">contact support</a>.</p>
  <p>Server logs contain details of this error with request ID: ABC-123.</p>
</body>
</html>''';

const unexpectedJsonResponse = '''
{
    "error": "API missed handle this error so this come directly to clients"
}
''';
