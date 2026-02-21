param kvResourceId string
param projectName string
param location string
param subnetId string

resource kvPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: '${projectName}-kv-pe'
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'kvConnection'
        properties: {
          privateLinkServiceId: kvResourceId
          groupIds: [
            'vault'
          ]
        }
      }
    ]
  }
}

// ... (resource definitions)

output privateEndpointId string = kvPrivateEndpoint.id
