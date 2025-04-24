# ####        Subscription IDs

# variable "MF-MDI-DEV-Subscription" {
#   type    = string
#   default = "5d225f46-3a3f-4729-a5ec-dffd77831244"
# }

# variable "MF-Core-Infrastructure-NonProd" {
#   type    = string
#   default = "6b5fafad-c388-4834-8e16-daf9828deb84"
# }

# variable "MF-Core-Infrastructure-Prod" {
#   type    = string
#   default = "65763622-4bd1-45e6-82fc-2f11e3663439"
# }

# variable "Microsoft-Azure-Enterprise" {
#   type    = string
#   default = "305431ef-6050-4a2d-bebd-5c34eb991490"
# }

# variable "MF_tenant_id" {
#   type    = string
#   default = "59fa7797-abec-4505-81e6-8ce092642190"
# }


# ###            Terraform Client ID and Secrets

# variable "MF_Terraform_CS" {
#   type = string
# }

# variable "MF_terraform_CI" {
#   type    = string
#   default = "b58ca4ea-c798-4fdf-a9a4-16a878e4fb54"
# }

# variable "MF_CI_AAD_CS" {
#   type = string
# }

# variable "MF_AAD_client_id" {
#   type    = string
#   default = "bea87b4a-0c2f-4ff3-9fd6-c8d974405587"
# }

# ###       Tags

# locals {
#   tag_list_1 = {
#     "Application Name" = "McCain Manufacturing Digital"
#     "GL Code"          = "N/A"
#     "Environment"      = "DEV"
#     "IT Owner"         = "gregoire.caron@mccain.com"
#     "Organization"     = "McCain Foods Limited"
#     "Business Owner"   = "kdperkin@mccain.ca"
#     "Resource Owner"   = "gregoire.caron@mccain.com"
#     "Resource Posture" = "Private"
#     "Resource Type"    = "DEV"
#     "Onboard Date"     = "12/12/2022"
#     "Modified Date"    = "N/A"
#     "Built Using"      = "Terraform"
#     "Built By"         = "sayeed.mohammad@mccain.ca"
#   }
# }

# variable "cc_location" {
#   type        = string
#   default     = "Canada Central"
#   description = "Canada Central Region"
# }
# variable "cc_core_resource_group_name" {
#   type        = string
#   default     = "MF_MDIxMI_Github_DEV_RG"
#   description = "Resource Group Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "storage_location" {
#   type        = string
#   default     = "Canada Central"
#   description = "Canada Central Region"
# }

# variable "mf-mdi-cc-dev-cosmosdb_Name" {
#   type        = string
#   default     = "mf-mdi-cc-dev-cosmosdbdev"
#   description = "cosmos db Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_storage_resource_group_name" {
#   type        = string
#   default     = "MF_MDI_CC_STORAGE_DEV-RG"
#   description = "Resource Group Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_public_ip" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV-IP"
#   description = "Public IP for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_apim_public_ip" {
#   type        = string
#   default     = "MF_MDI_CC_APIM_DEV-IP"
#   description = "Public IP for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_public_ip_sku" {
#   type        = string
#   default     = "Standard"
#   description = "Public IP SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_vnet_name" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_CORE-VNET"
#   description = "Virtual Network Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_api_vnet_name" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_API-VNET"
#   description = "Virtual Network Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_appgw_subnet_name" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_APPGW-SNET"
#   description = "ACA Subnet Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_apimgt_subnet_name" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_APIM-SNET"
#   description = "ACA Subnet Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "MF_MDI_CC_DEV_SQLMI-SNET" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_SQLMI-SNET"
#   description = "ACA Subnet Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "MF_MDI_CC_DEV_CAPPS-SNET_name" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_CAPPS-SNET"
#   description = "ACA Subnet Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_appgw_name" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV_APPGW"
#   description = "Application Gateway Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# #variable "cc_core_appgw_sku" {
# #type = string
# #default = "WAF_v2"
# # description = "Application Gateway SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# #}
# #variable "cc_core_appgw_tier" {
# #type = string
# # default = "WAF_v2"
# # description = "Application Gateway SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# #}
# variable "cc_core_appgw_ip_config" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV_APPGW-IP-CONFIG"
#   description = "Application Gateway IP Configuration Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_appgw_nsg_NAME" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_APPGW-NSG"
#   description = "Application Gateway NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_capps_nsg_NAME" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_CAPPS-NSG"
#   description = "Application Gateway NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_apimgt_nsg_Name" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_APIM-NSG"
#   description = "Application Management NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_core_sqlmi_nsg" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_SQLMI-NSG"
#   description = "Application Gateway NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_apimgt_name" {
#   type        = string
#   default     = "MF-MDI-CC-DEV-APIMGT"
#   description = "API Management Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_apimgt_sku" {
#   type        = string
#   default     = "Premium_1"
#   description = "API Management SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_apimgt_api_name" {
#   type        = string
#   default     = "MdiXAi-Auth-service"
#   description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_apimgt_logger_name" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV_APPGW-LOGGER"
#   description = "Azure API Management Logger Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_apimgt_nsg" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_APIMGT-NSG"
#   description = "API Management NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_core_law_name" {
#   type        = string
#   default     = "MF-MDI-CC-CORE-DEV-LAW"
#   description = "Log Analytics Workspace Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_law_sku" {
#   type        = string
#   default     = "PerGB2018"
#   description = "Log Analytics Workspace SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_auth_appinsights_name" {
#   type        = string
#   default     = "MF_MDI_CC_AUTH_DEV_APP_INSIGHTS"
#   description = "Application Insights Name  - Auth Service for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_dcl_appinsights_name" {
#   type        = string
#   default     = "MF_MDI_CC_DCL_DEV_APP_INSIGHTS"
#   description = "Application Insights Name - DCL for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_ddds_appinsights_name" {
#   type        = string
#   default     = "MF_MDI_CC_DDDS_DEV_APP_INSIGHTS"
#   description = "Application Insights Name - DDMC for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_ddh_appinsights_name" {
#   type        = string
#   default     = "MF_MDI_CC_DDH_DEV_APP_INSIGHTS"
#   description = "Application Insights Name - DDH for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_dev_key_vault" {
#   type        = string
#   default     = "MF-MDI-CORE-DEV-KV"
#   description = "Application Gateway Key Vault Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_dev_key_vault_sku" {
#   type        = string
#   default     = "standard"
#   description = "Application Gateway Key Vault SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_appgw_user_identity" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV_APPGW-USER-IDENTITY"
#   description = "Application Gateway Managed User Identity Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_core_appgw_kv_access_policy" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV_APPGW_KEY_VAULT_ACCESS_POLICY"
#   description = "Application Gatway Key Vault Access Policy for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_appgw_kv_certificate" {
#   type        = string
#   default     = "digital-manufacturing-dev-cert"
#   description = "Application Gateway Key Vault Certificate for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_appgw_kv_certificate-cer" {
#   type        = string
#   default     = "digital-manufacturing-dev-cert-cer"
#   description = "Application Gatway Key Vault Root Certificate for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_domain_name" {
#   type    = string
#   default = "mccain.com"
#   #default = "mccain.com"
#   description = "Domain Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_apim_app_link" {
#   type        = string
#   default     = "MFMDCCAppGatewayApimLink"
#   description = "Application Gateway Private DNS Link Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_core_apim_api_a_record" {
#   type        = string
#   default     = "dev-mdi-ai"
#   description = "API A record Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_apim_kv_cert_secret" {
#   type        = string
#   default     = "mfmdicccorecertsecret"
#   description = "Certificate Key Vault Secret Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_appgateway_root_cert" {
#   type        = string
#   default     = "mfmdcccorecertsecret"
#   description = "App Gateway Trusted Root Cert Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_ssl_certificate_name" {
#   type        = string
#   default     = "mfmdcccorecertsecret"
#   description = "Certificate Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "mf_mdi_cc_core_DEV_appgw_policy" {
#   type        = string
#   default     = "mf_mdi_cc_core_DEV_appgw_policy1"
#   description = "Application Gatway Key Vault Access Policy for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "MF_MDI_CC_CORE-DEV-SQLMI" {
#   type        = string
#   default     = "MF_MDI_CC_CORE-DEV-SQLMI"
#   description = "SQL managed Instance for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_core_dev_acr_name" {
#   type        = string
#   default     = "MFMDICCCOREDEVACR"
#   description = "container registry for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "acr_login_url" {
#   type        = string
#   default     = "mfmdicccoredevacr.azurecr.io"
#   description = "ACR Login Server URL for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_core_dev_acr_sku" {
#   type        = string
#   default     = "Standard"
#   description = "Container Registry SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "mf-mdi-cc-capp_mdixaiauthservice_image_name" {
#   type        = string
#   default     = "mdixaiauthservice"
#   description = "containerapp for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "MF_MDI_CC_DEV-CAPPENV_NAME" {
#   type        = string
#   default     = "mf-mdi-cc-dev-cappenv"
#   description = "containerapp Environment for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "MF_MDI_CC_DEV_SQLMI-rt" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_SQLMI-rt"
#   description = "route table for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_appinsights_name" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV_APP_INSIGHTS"
#   description = "App Insights for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }


# variable "MF_MDI_CC_DEV-CAPP-MDIAUTHSERVICE_NAME" {
#   type        = string
#   default     = "mf-mdi-cc-dev-capp-mdiauthsvc"
#   description = "Placeholder"
# }

# variable "capp-mdixaiauthservice_name" {
#   type        = string
#   default     = "mdixaiauthservice"
#   description = "Placeholder"
# }

# variable "MF_MDI_CC_DEV-CAPP-DDDS_NAME" {
#   type        = string
#   default     = "mf-mdi-cc-dev-capp-ddds"
#   description = "Placeholder"
# }

# variable "capp-mdixaiddds_name" {
#   type        = string
#   default     = "mdixaiddss"
#   description = "Placeholder"
# }

# variable "cc_core_apimgt_api_ddds" {
#   type        = string
#   default     = "mdixaiddss"
#   description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "MF_MDI_CC_DEV-CAPP-ddh_NAME" {
#   type        = string
#   default     = "mf-mdi-cc-dev-capp-ddh"
#   description = "Placeholder"
# }

# variable "capp-mdixaiddh_name" {
#   type        = string
#   default     = "mdixaiddh"
#   description = "Placeholder"
# }
# variable "cc_core_apimgt_api_ddh" {
#   type        = string
#   default     = "mdixaiddh"
#   description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "MF_MDI_CC_DEV-CAPP-dcl_NAME" {
#   type        = string
#   default     = "mf-mdi-cc-dev-capp-dcl"
#   description = "Placeholder"
# }

# variable "capp-mdixaidcl_name" {
#   type        = string
#   default     = "mdixaidcl"
#   description = "Placeholder"
# }
# variable "cc_core_apimgt_api_dcl" {
#   type        = string
#   default     = "mdixaidcl"
#   description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "MF_MDI_CC_DEV-CAPP-cid_NAME" {
#   type        = string
#   default     = "mf-mdi-cc-dev-capp-cid"
#   description = "Placeholder"
# }

# variable "capp-mdixaicid_name" {
#   type        = string
#   default     = "mdixaicid"
#   description = "Placeholder"
# }
# variable "cc_core_apimgt_api_cid" {
#   type        = string
#   default     = "mdixaicid"
#   description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "mf_mdi_cc_dev_sa_name" {
#   type        = string
#   default     = "mfmdicccoredevsa"
#   description = "Storage accout for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "MF_MDI_CC_DEV_APPGW_Name" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV_APPGW"
#   description = "Application Gateway Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_core_appgw_sku" {
#   type        = string
#   default     = "Standard_v2"
#   description = "Application Gateway SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_core_appgw_tier" {
#   type        = string
#   default     = "Standard_v2"
#   description = "Application Gateway SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "appgw-public-ip_NAME" {
#   type        = string
#   default     = "appgw-public-ip"
#   description = "Public IP for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "MF_MDI_CC_CORE_DEV-appSP_Name" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV-appSP"
#   description = "webapp Service plan for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "MF-MDI-CC-CORE-DEV-Webapp_Name" {
#   type        = string
#   default     = "MF-MDI-CC-CORE-DEV-Webapp"
#   description = "webapp for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_vnet_aca_app_link" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_CORE_APP_LINK"
#   description = "CORE VNet link to Azure Container Apps Private DNS Link Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_api_vnet_aca_app_link" {
#   type        = string
#   default     = "MF_MDI_CC_DEV_API_APP_LINK"
#   description = "API VNet link to Azure Container Apps Private DNS Link Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }
# variable "cc_core_web_ui_a_record" {
#   type        = string
#   default     = "mf-mdi-cc-core-dev-webapp.azurewebsites.net"
#   description = "API A record Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "cc_core_sql_cs" {
#   type        = string
#   default     = "Server=tcp:mf-mdi-cc-core-dev-sqlmi.b3cb9f81e128.database.windows.net,1433;Initial Catalog=MDIxAI_DEV;Persist Security Info=False;User ID=sqlmidevadmin;Password=Sql@MI2024TcsMcn;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
#   description = "SQL CS for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "MF_MDI_CC_CORE_DEV-logicappSP_Name" {
#   type        = string
#   default     = "MF_MDI_CC_CORE_DEV-LASP"
#   description = "webapp Service plan for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }

# variable "MF-MDI-CC-CORE-DEV-Logicappsap_Name" {
#   type        = string
#   default     = "MF-MDI-CC-CORE-DEV-LA-SAP"
#   description = "Logicapp for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
# }
