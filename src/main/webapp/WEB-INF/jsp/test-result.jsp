<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Result</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4>Fine Calculation Test Result</h4>
                    </div>
                    <div class="card-body">
                        <p>${message}</p>
                        
                        <a href="/loans" class="btn btn-primary">Back to Loans</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>