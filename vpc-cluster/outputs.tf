output vpc_arn {
  value = aws_vpc.custom_vpc.arn
}

output vpc_id {
  value = aws_vpc.custom_vpc.id
}

output private_subnet_ids {
  value = aws_subnet.private_subnet.*.id
}

output aws_security_group_alb_id {
  value = aws_security_group.lb.id
}

