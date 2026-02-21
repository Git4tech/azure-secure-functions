param location string
param projectName string
param subnetId string

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${projectName}-kv'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    enableRbacAuthorization: true
    publicNetworkAccess: 'Disabled'
  }
}


output keyVaultId string = keyVault.id
