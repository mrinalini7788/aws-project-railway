# Create the VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = { Name = var.vpc_name }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.vpc_name}-igw" }
}

# Create Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.cidr_public_subnet)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.cidr_public_subnet[count.index]
  availability_zone       = var.eu_availability_zone[count.index]
  
  # CRITICAL: This allows the VM to get a Public IP for SSH
  map_public_ip_on_launch = true 
  
  tags = { Name = "${var.vpc_name}-public-${count.index}" }
}

# Create the Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.vpc_name}-public-rt" }
}

# ADD THE ROUTE (This is likely what's missing!)
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Associate Subnets with the Public Route Table
resource "aws_route_table_association" "public" {
  count          = length(var.cidr_public_subnet)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
