class Schema {

  String login = """
    mutation {
      login(email: "bytesharedmin@gmail.com", password: "adminbyteshare5556"){  
        id,
        fullname,
        avatar,
        gender,
        dob,
        email,
        password,
      }
    }
  """;

  String students = """
    query {
      students{
        id,
        role,
        studentId,
        fullname,
        email,
        password,
        avatar,
        dob,
        qr,
        gender,
        message,
        token,
        statusCode,
        isApproved,
        created_at
      }
    }
  """;
}