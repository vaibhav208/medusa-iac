resource "aws_ecs_cluster" "main" {
  name = "medusa-cluster"
}

resource "aws_ecs_task_definition" "medusa" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = "medusa"
    image = "${aws_ecr_repository.medusa.repository_url}:latest"
    essential = true
    portMappings = [{ containerPort = 9000 }]
    environment = [
      { name = "DATABASE_URL", value = "postgres://medusa:medusadb123@${aws_db_instance.medusa.address}:5432/medusadb" },
      { name = "JWT_SECRET", value = "secretjwt" },
      { name = "COOKIE_SECRET", value = "secretcookie" }
    ]
  }])
}

resource "aws_ecs_service" "medusa" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.medusa.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.public[*].id
    security_groups = [aws_security_group.lb.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.medusa_tg.arn
    container_name   = "medusa"
    container_port   = 9000
  }
  depends_on = [aws_lb_listener.listener]
}resource "aws_ecs_cluster" "main" {
  name = "medusa-cluster"
}

resource "aws_ecs_task_definition" "medusa" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = "medusa"
    image = "${aws_ecr_repository.medusa.repository_url}:latest"
    essential = true
    portMappings = [{ containerPort = 9000 }]
    environment = [
      { name = "DATABASE_URL", value = "postgres://medusa:medusadb123@${aws_db_instance.medusa.address}:5432/medusadb" },
      { name = "JWT_SECRET", value = "secretjwt" },
      { name = "COOKIE_SECRET", value = "secretcookie" }
    ]
  }])
}

resource "aws_ecs_service" "medusa" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.medusa.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.public[*].id
    security_groups = [aws_security_group.lb.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.medusa_tg.arn
    container_name   = "medusa"
    container_port   = 9000
  }
  depends_on = [aws_lb_listener.listener]
}