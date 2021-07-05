variable "project_tags" {
    type        = map(string)
    default     = {
        Component   = "Frontend"
        Environment = "Production"
    }
}