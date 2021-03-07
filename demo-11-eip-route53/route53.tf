resource "aws_route53_zone" "ngoctp-xyz" {
    name    = "ngoctp.xyz"
}
resource "aws_route53_record" "server1-record" {
    zone_id = aws_route53_zone.ngoctp-xyz.zone_id
    name    = "server1.ngoctp.xyz"
    type    = "A"
    ttl     = "300"
    records = [""]
}

resource "aws_route53_record" "www-record" {
    zone_id = aws_route53_zone.ngoctp-xyz.zone_id
    name    = "www.ngoctp.xyz"
    type    = "A"
    ttl     = "300"
    records = [""]
}
resource "aws_route53_record" "mail1-record" {
    zone_id = aws_route53_zone.ngoctp-xyz.zone_id
    name    = "ngoctp.xyz"
    type    = "MX"
    ttl     = "300"
    records = [
        
    ]
}
output "ns-servers" {
    value = aws_route53_zone.ngoctp-xyz.name-servers
}