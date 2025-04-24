variable "cc_location" {
  type        = string
  default     = "Canada Central"
  description = "Canada Central Region"
}

variable "cc_core_resource_group_name" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_CORE-RG"
  description = "Resource Group Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "storage_location" {
  type        = string
  default     = "Canada Central"
  description = "Canada Central Region"
}


variable "MF_tenant_id" {
  type    = string
  default = "59fa7797-abec-4505-81e6-8ce092642190"
}
###########COSMO DB VARIABLE #########################################


variable "mf-dm-cc-preprod-cosmosdbPERF_Name" {
  type        = string
  default     = "mf-dm-cc-preprod-cosmosdb"
  description = "cosmos db Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}


##############################################################
variable "cc_storage_resource_group_name" {
  type        = string
  default     = "MF_DM_CC_STORAGE-PRE_PROD-RG"
  description = "Resource Group Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_public_ip" {
  type        = string
  default     = "MF_DM_CC_APIM_PRE_PROD_API-IP"
  description = "Public IP for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_apim_public_ip" {
  type        = string
  default     = "MF_DM_CC_APIM_PRE_PROD_API-IP"
  description = "Public IP for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_public_ip_sku" {
  type        = string
  default     = "Standard"
  description = "Public IP SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_vnet_name" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_CORE-VNET"
  description = "Virtual Network Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_api_vnet_name" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_API-VNET"
  description = "Virtual Network Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_appgw_subnet_name" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_APPGW-SNET"
  description = "ACA Subnet Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_apimgt_subnet_name" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_APIM-SNET"
  description = "ACA Subnet Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "MF_DM_CC_PRE_PROD_SQLMI-SNET" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_SQLMI-SNET"
  description = "ACA Subnet Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "MF_DM_CC_PRE_PROD_CAPPS-SNET" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_CAPPS-SNET"
  description = "ACA Subnet Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

###Gateway variables#############


variable "cc_core_appgw_name" {
  type        = string
  default     = "MF_DM_CC_CORE_PRE_PROD_APPGW"
  description = "Application Gateway Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
#variable "cc_core_appgw_sku" {
#type = string
#default = "WAF_v2"
# description = "Application Gateway SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
#}
#variable "cc_core_appgw_tier" {
#type = string
# default = "WAF_v2"
# description = "Application Gateway SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
#}
variable "cc_core_appgw_ip_config" {
  type        = string
  default     = "MF_DM_CC_CORE_PRE_PROD_APPGW-IP-CONFIG"
  description = "Application Gateway IP Configuration Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_appgw_nsg_NAME" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_APPGW-NSG"
  description = "Application Gateway NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_capps_nsg_NAME" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_CAPPS-NSG"
  description = "Application Gateway NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_apimgt_nsg_NAME" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_APIM-NSG"
  description = "Application Management NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_sqlmi_nsg" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_SQLMI-NSG"
  description = "Application Gateway NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

######### APIM VARIABLES###############

variable "cc_core_apimgt_name" {
  type        = string
  default     = "MF-DM-CC-PRE-PROD-APIMGT"
  description = "API Management Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_apimgt_sku" {
  type        = string
  default     = "Developer_1"
  description = "API Management SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_apimgt_api_name" {
  type        = string
  default     = "MdiXAi-Auth-service"
  description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_apimgt_logger_name" {
  type        = string
  default     = "MF_DM_CC_CORE_PRE_PROD_APPGW-LOGGER"
  description = "Azure API Management Logger Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_apimgt_nsg" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_APIMGT-NSG"
  description = "API Management NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

###############log analytics variable ######################################################
variable "cc_core_law_name" {
  type        = string
  default     = "MF-DM-CC-CORE-PRE-PROD-LAW"
  description = "Log Analytics Workspace Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_law_sku" {
  type        = string
  default     = "PerGB2018"
  description = "Log Analytics Workspace SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}


################################################################################


variable "cc_auth_appinsights_name" {
  type        = string
  default     = "MF_DM_CC_AUTH_PRE_PROD_APP_INSIGHTS"
  description = "Application Insights Name  - Auth Service for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_dcl_appinsights_name" {
  type        = string
  default     = "MF_DM_CC_DCL_PRE_PROD_APP_INSIGHTS"
  description = "Application Insights Name - DCL for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_ddds_appinsights_name" {
  type        = string
  default     = "MF_DM_CC_DDDS_PRE_PROD_APP_INSIGHTS"
  description = "Application Insights Name - DDMC for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_ddh_appinsights_name" {
  type        = string
  default     = "MF_DM_CC_DDH_PRE_PROD_APP_INSIGHTS"
  description = "Application Insights Name - DDH for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

###KEY VALUT VARIABLE#####################
variable "cc_core_PRE_PROD_key_vault" {
  type        = string
  default     = "MF-DM-CORE-PRE-PROD-KV"
  description = "Application Gateway Key Vault Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_PRE_PROD_key_vault_sku" {
  type        = string
  default     = "standard"
  description = "Application Gateway Key Vault SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_appgw_user_identity" {
  type        = string
  default     = "MF_DM_CC_CORE_PRE_PROD_APPGW-USER-IDENTITY"
  description = "Application Gateway Managed User Identity Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_appgw_kv_access_policy" {
  type        = string
  default     = "MF_DM_CC_CORE_PRE_PROD_APPGW_KEY_VAULT_ACCESS_POLICY"
  description = "Application Gatway Key Vault Access Policy for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}



variable "cc_core_appgw_kv_certificate" {
  type        = string
  default     = "digital-manufacturing-train-cert"
  description = "Application Gateway Key Vault Certificate for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_appgw_kv_certificate-cer" {
  type        = string
  default     = "digital-manufacturing-train-cert-cer"
  description = "Application Gatway Key Vault Root Certificate for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}


################private DNS######################

variable "cc_core_domain_name" {
  type    = string
  default = "mccain.com"
  #default = "mccain.com"
  description = "Domain Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_apim_app_link" {
  type        = string
  default     = "MFDMCCAppGatewayApimLink"
  description = "Application Gateway Private DNS Link Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_apimgt_api_ddh" {
  type        = string
  default     = "dmxaiddh"
  description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_apim_api_a_record" {
  type        = string
  default     = "train-mdixai"
  description = "API A record Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_apim_kv_cert_secret" {
  type        = string
  default     = "mfdmcccorecertsecret"
  description = "Certificate Key Vault Secret Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_appgateway_root_cert" {
  type        = string
  default     = "mfdmcccorecertsecret"
  description = "App Gateway Trusted Root Cert Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_ssl_certificate_name" {
  type        = string
  default     = "mfdmcccorecertsecret"
  description = "Certificate Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}



variable "mf_dm_cc_core_PRE_PROD_appgw_policy" {
  type        = string
  default     = "mf_dm_cc_core_PRE_PROD_appgw_policy1"
  description = "Application Gatway Key Vault Access Policy for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}


variable "MF_DM_CC_CORE-PRE_PROD-SQLMI" {
  type        = string
  default     = "MF_DM_CC_CORE-PRE_PROD-SQLMI"
  description = "SQL managed Instance for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

####### AZURE CONTAINER REGISTRY VARIABLE ###################

variable "cc_core_acr_name" {
  type        = string
  default     = "MFDMCCCOREPREPRODACR"
  description = "container registry for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_acr_sku" {
  type        = string
  default     = "Standard"
  description = "Container Registry SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

##### should be provided by tanner###########

variable "acr_login_url" {
  type        = string
  default     = "mfdmcccorepreprodacr.azurecr.io"
  description = "ACR Login Server URL for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}



##########AZURE CONTAINER APPS#############

variable "MF_DM_CC-CAPPENV_NAME" {
  type        = string
  default     = "mf-dm-cc-preprod-cappenv"
  description = "containerapp Environment for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "MF_DM_CC_SQLMI-rt" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_SQLMI-rt"
  description = "route table for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

##########APP INSIGHT VARIABLE################
variable "cc_core_appinsights_name" {
  type        = string
  default     = "MF_DM_CC_CORE_PRE_PROD_APP_INSIGHTS"
  description = "App Insights for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

#################################################

variable "MF_DM_CC-CAPP-MDIAUTHSERVICE_NAME" {
  type        = string
  default     = "mf-dm-cc-preprod-capp-dmauthsvc"
  description = "Placeholder"
}

variable "capp-dmxaiauthservice_name" {
  type        = string
  default     = "dmxaiauthservice"
  description = "Placeholder"
}

########storage account variable##############3

variable "mf_dm_cc_sa_name" {
  type        = string
  default     = "mfdmccpreprodghcoresa"
  description = "Storage accout for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

####################################################

variable "MF_DM_CC_APPGW_Name" {
  type        = string
  default     = "MF_DM_CC_CORE_PRE_PROD_APPGW"
  description = "Application Gateway Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_appgw_sku" {
  type        = string
  default     = "Standard_v2"
  description = "Application Gateway SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_appgw_tier" {
  type        = string
  default     = "Standard_v2"
  description = "Application Gateway SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "appgw-public-ip_NAME" {
  type        = string
  default     = "preprod-appgw-public-ip"
  description = "Public IP for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

##############web app variable################################

variable "MF_DM_CC_CORE-appSP_Name" {
  type        = string
  default     = "MF_DM_CC_CORE_PRE_PROD-appSP"
  description = "webapp Service plan for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "MF-DM-CC-CORE-Webapp_Name" {
  type        = string
  default     = "MF-DM-CC-CORE-PRE-PROD-Webapp"
  description = "webapp for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

#################################################################################
variable "cc_core_vnet_aca_app_link" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_CORE_APP_LINK"
  description = "CORE VNet link to Azure Container Apps Private DNS Link Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_api_vnet_aca_app_link" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_API_APP_LINK"
  description = "API VNet link to Azure Container Apps Private DNS Link Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_web_ui_a_record" {
  type        = string
  default     = "mf-dm-cc-core-pre-prod-webapp.azurewebsites.net"
  description = "API A record Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

#########Provided by tanner ################

# variable "cc_core_sql_cs" {
#   type        = string
#   default     = "Server=tcp:mf-dm-cc-core-DEV-sqlmi.2c3f08afd40c.database.windows.net,1433;Persist Security Info=False;User ID={your_username};Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
#   description = "SQL CS for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
# }

variable "MF_DM_CC-PRE_PROD-CAPP-DDDS_NAME" {
  type        = string
  default     = "mf-dm-cc-preprod-capp-ddds"
  description = "Placeholder"
}

variable "capp-dmxaiddss_name" {
  type        = string
  default     = "dmxaiddss"
  description = "Placeholder"
}
variable "cc_core_apimgt_api_ddds" {
  type        = string
  default     = "dmxaiddss"
  description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "MF_DM_CC-CAPP-ddh_NAME" {
  type        = string
  default     = "mf-dm-cc-preprod-capp-ddh"
  description = "Placeholder"
}

variable "capp-dmxaiddh_name" {
  type        = string
  default     = "dmxaiddh"
  description = "Placeholder"
}

variable "MF_DM_CC-PRE_PROD-CAPP-dcl_NAME" {
  type        = string
  default     = "mf-dm-cc-preprod-capp-dcl"
  description = "Placeholder"
}

variable "capp-dmxaidcl_name" {
  type        = string
  default     = "dmxaidcl"
  description = "Placeholder"
}
variable "cc_core_apimgt_api_dcl" {
  type        = string
  default     = "dmxaidcl"
  description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "MF_DM_CC-PRE_PROD-CAPP-cid_NAME" {
  type        = string
  default     = "mf-dm-cc-preprod-capp-cid"
  description = "Placeholder"
}

variable "capp-dmxaicid_name" {
  type        = string
  default     = "dmxaicid"
  description = "Placeholder"
}
variable "cc_core_apimgt_api_cid" {
  type        = string
  default     = "dmxaicid"
  description = "Azure API Management APIs Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

#####Logic APP varibales##################

variable "MF_DM_CC_CORE-PRE_PROD-logicappSP_Name" {
  type        = string
  default     = "MF_DM_CC_CORE-PRE_PROD-LASP"
  description = "webapp Service plan for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "MF-DM-CC-CORE-PRE-PROD-Logicappsap_Name" {
  type        = string
  default     = "MF-DM-CC-CORE-PRE-PROD-LA-SAP"
  description = "Logicapp for McCain Food Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_rptvm_subnet_name" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_RPTVM-SNET"
  description = "VM Subnet Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "cc_core_rptvm_nsg_NAME" {
  type        = string
  default     = "MF_DM_CC_PRE_PROD_RPTVM-NSG"
  description = "Linux VM NSG Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

#####Private DNS Variables##################

variable "MF_DM_CC_CORE-PRE_PROD-Cosmos-DNS-Name" {
  type    = string
  default = "privatelink.documents.azure.com"
}
variable "MF_DM_CC_CORE-PRE_PROD-Cosmos-DNS-VLink" {
  type    = string
  default = "MF_DM_Demo_DNS_VLink"
}
variable "MF_DM_CC_CORE-PRE_PROD-Cosmos-DNS-Record" {
  type    = string
  default = "mf-dm-cc-preprod-cosmosdb"
}
variable "MF_DM_CC_CORE-PRE_PROD-Cosmos-IPs" {
  type    = list(string)
  default = ["10.124.77.6"]

}

variable "cc_core_key_vault" {
  type        = string
  default     = "MF-DM-CC-CORE-PREPROD-KV"
  description = "Application Gateway Key Vault Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
variable "cc_core_key_vault_sku" {
  type        = string
  default     = "standard"
  description = "Application Gateway Key Vault SKU for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}

variable "mf-dm-cc-cosmosdb_Name" {
  type        = string
  default     = "mf-dm-cc-preprod-cosmosdbpreprod"
  description = "cosmos db Name for McCain Foods Manufacturing Digital Shared Azure Components in Canada Central"
}
