This module requires a list of objects for it's input. Additionally all LB `name` attributes must be unique as the module itterates over the list and creates a resource for each name. See `terraform_modules/examples/aws_lb/main.tf` for an example that will create three LB of the types application, network, and gateway.