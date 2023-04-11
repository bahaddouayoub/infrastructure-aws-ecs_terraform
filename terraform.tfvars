region = "us-east-1"
environment = "prod"
vpc_tag_name = "ecs-cluster"
number_of_private_subnets = 2
private_subnet_tag_name = "private-subnet"
vpc_cidr_block = "11.0.0.0/16"
private_subnet_cidr_blocks = ["11.0.1.0/24", "11.0.4.0/24", "11.0.3.0/24"]
security_group_lb_name= "alb-sg"
security_group_ecs_tasks_name = "ecs-tasks-sg"
security_group_lb_description = "allow inbound access from vpc only"
security_group_ecs_tasks_description = "allow inbound access from alb security group only"
app_port = 5000
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

namespace = "devCluster"
cluster_tag_name = "ecs-DevCluster"

app_image_movie = "163115913121.dkr.ecr.us-east-1.amazonaws.com/my-repo:movie1"
app_image_home = "163115913121.dkr.ecr.us-east-1.amazonaws.com/my-repo:home1"
app_count = "2"
movie_dns_name= "movie"
home_dns_name = "home"
home_family_name = "home"
home_container_name = "home"
home_port_mapping = "home"
movie_family_name = "movie"
movie_container_name = "movie"
movie_port_mapping = "movie"

health_check_path_movie = "/movie"
health_check_path_home = "/home"
tg_name_home = "home-tg"
tg_name_movie = "movie-tg"

path_pattern_home = "home/*"
path_pattern_movie = "movie/*"

security_group_ecs_tasks_name_movie = "movie-ecs-task-sg"
security_group_ecs_tasks_name_home = "home-ecs-task-sg"



# database variables
parameter_group_name = "beauty-bench-db"
parameter_group_family = "postgres14"
db_username = "your user"
db_password = "your passwd"
db_port = 5432
allocated_storage     = 100
max_allocated_storage = 500
storage_type          = "io1"

instance_class= "db.t3.medium"

skip_final_snapshot = false

multi_az = false
enabled_cloudwatch_logs_exports= true
param_log_statement= "none"
