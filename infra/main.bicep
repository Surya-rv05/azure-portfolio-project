// =============================================
// Project 1 — Portfolio Site Infrastructure
// Author: Surya
// Description: Static website hosting on Azure
//              Blob Storage with security best practices
// =============================================

@description('Environment name')
param environment string = 'dev'

@description('Azure region')
param location string = resourceGroup().location

// ---- Variables ----
var storageAccountName = 'st${uniqueString(resourceGroup().id)}'

// =============================================
// STORAGE ACCOUNT
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
    supportsHttpsTrafficOnly: true       // Force HTTPS
    minimumTlsVersion: 'TLS1_2'          // Modern TLS only
    allowBlobPublicAccess: true          // Needed for static website
    allowSharedKeyAccess: false          // SECURITY: Force Entra ID auth
  }
}

// =============================================
// BLOB SERVICE — Soft Delete + Versioning
// =============================================
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 7              // Recover deleted blobs within 7 days
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7              // Recover deleted containers within 7 days
    }
    isVersioningEnabled: true   // Keep version history of all changes
  }
}

// =============================================
// OUTPUTS
// =============================================
output storageAccountName string = storageAccount.name
output staticWebsiteUrl string = storageAccount.properties.primaryEndpoints.web
