terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = ">= 1.0.0" # Refer to docs for latest version
    }
  }
}

provider "auth0" {
    domain        = "csnkarthik.auth0.com"
    client_id     = "wRuqCWyq0We2NVLIa8lKVI42fEDtC3X4"
    client_secret = "HvT0c-qsXdlvYhxC36QLXtWqqDfKA_9A4zOVk7KJP2rtiMXVF8dcXPjKlZ6OQXMO"
}

resource "auth0_client" "my_client" {
  name            = var.application_name
  description     = var.application_description
  app_type        = var.application_app_type
  callbacks       = [var.application_callbacks]
  oidc_conformant = var.application_oidc_conformant

  jwt_configuration {
    alg = "RS256"
  }
}