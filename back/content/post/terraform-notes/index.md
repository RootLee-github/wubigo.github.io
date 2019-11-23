+++
title = "Terraform Notes"
date = 2017-11-23T15:11:01+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["LOCALSTACK","TERRAFORM"]
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++

## 前提条件

### 配置AWS

```
aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************s-ok shared-credentials-file
secret_key     ****************-key shared-credentials-file
    region                    local      config-file    ~/.aws/config
```

`~/.aws/config`

```
[default]
output = json
region = local
```

`~/.aws/credentials`

```
[default]
aws_access_key_id = any-id-is-ok
aws_secret_access_key = fake-key
```

### 启动aws本地服务

```
localstack start
```


## 创建EC2

### 配置

```
mkdir ec2

cd ec2

touch ec2.tf
```

`ec2.tf`

```
provider "aws" {
  profile    = "default"
  region     = "us-east-1"
  endpoints {
      ec2    = "http://localhost:4597"
      sts    = "http://localhost:4592"
  }

}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}

```

### 初始化

- 下载SP

```
terraform  init
```
- 应用配置

```
terraform apply
```

### 检查结果

```
awslocal ec2 describe-instances
```
