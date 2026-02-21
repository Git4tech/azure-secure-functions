param privateEndpointSubnetId string
param projectName string
param location string
param functionAppId string
param functionAppPrincipalId string

resource functionPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-04-01' = {
  name: '${projectName}-func-pe'
  location: location
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'funcConnection'
        properties: {
          privateLinkServiceId: functionAppId
          groupIds: [
            'sites'
          ]
        }
      }
    ]
  }
}


output functionPrincipalId string = functionAppPrincipalId
