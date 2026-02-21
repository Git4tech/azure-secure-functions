param functionPrincipalId string
param keyVaultId string
param storageAccountId string

resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = {
  name: split(keyVaultId, '/')[8]
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: split(storageAccountId, '/')[8]
}

resource kvRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVaultId, functionPrincipalId, 'kv-role')
  scope: keyVault
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      '4633458b-17de-408a-b874-0445c86b69e6' // Key Vault Secrets User
    )
    principalId: functionPrincipalId
    principalType: 'ServicePrincipal'
  }
}

resource storageRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storageAccountId, functionPrincipalId, 'storage-role')
  scope: storageAccount
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      'ba92f5b4-2d11-453d-a403-e96b0029c9fe' // Storage Blob Data Contributor
    )
    principalId: functionPrincipalId
    principalType: 'ServicePrincipal'
  }
}
