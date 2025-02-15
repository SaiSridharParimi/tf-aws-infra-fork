resource "aws_subnet" "main_public_subnet" {
  depends_on        = [aws_vpc.main]
  vpc_id            = aws_vpc.main.id
  count             = length(var.public_subnet_cidr)
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = format("main-public-subnet-%d", count.index)
  }
}

resource "aws_subnet" "main_private_subnet" {
  depends_on        = [aws_vpc.main]
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnet_cidr)
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = format("main-private-subnet-%d", count.index)
  }
}