// =============================================
// Project 1 — Portfolio Site Infrastructure
// Author: Surya
// Description: Static website hosting on Azure
//              Blob Storage Static Website
// =============================================

@description('Environment name')
param environment string = 'dev'

@description('Azure region')
param location string = resourceGroup().location

// ---- Variables ----
var storageAccountName = 'st${uniqueString(resourceGroup().id)}'

// =============================================
// STORAGE ACCOUNT — hosts the static website
// =============================================
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
  }
}

// =============================================
// OUTPUTS
// =============================================
output storageAccountName string = storageAccount.name
output staticWebsiteUrl string = storageAccount.properties.primaryEndpoints.web