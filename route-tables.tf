resource "aws_route_table" "main_public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name = var.public_rt_name
  }
}

resource "aws_route_table_association" "main_public_rt_assoc" {
  route_table_id = aws_route_table.main_public_rt.id
  count          = length(aws_subnet.main_public_subnet)
  subnet_id      = aws_subnet.main_public_subnet[count.index].id
}

resource "aws_route_table" "main_private_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.private_rt_name
  }

}

resource "aws_route_table_association" "main_private_rt_assoc" {
  route_table_id = aws_route_table.main_private_rt.id
  count          = length(aws_subnet.main_private_subnet)
  subnet_id      = aws_subnet.main_private_subnet[count.index].id
}