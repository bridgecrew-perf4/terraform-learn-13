[
  {
      "essential": true,
      "memory": 256,
      "name": "ersl-admin-console-dev2",
      "cpu": 256,
      "image": "${REPOSITORY_URL}:1.2",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
  }
]