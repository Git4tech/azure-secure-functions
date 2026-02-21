param location string
param projectName string
param subnetId string

resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: '${projectName}storage'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    publicNetworkAccess: 'Disabled'
  }
}

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: '${projectName}-storage-pe'
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'storageConnection'
        properties: {
          privateLinkServiceId: storage.id
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
}

// ... (resource definitions)

output storageAccountName string = storage.name
output storageAccountId string = storage.id
