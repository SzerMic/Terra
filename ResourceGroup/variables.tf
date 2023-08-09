variable "rs_name" {
  type        = string
  description = "Nazwa resource grupy"
  # default = "PoC-12312-asd-asd1-2e"
}
variable "rs_location" {
  type    = string
  description = "Lokalizacja"
  # default = "West Europe"
}
variable "tags" {
  type = map(any)
  description = "nazwy tagow"
}