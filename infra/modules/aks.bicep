param location string
param aksName string
param dnsPrefix string

resource aks 'Microsoft.ContainerService/managedClusters@2023-05-01' = {
  name: aksName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: dnsPrefix

    agentPoolProfiles: [
      {
        name: 'nodepool'
        count: 1
        // vmSize: 'Standard_L8s_v4' // worked for dev, failed in test for quota
        vmSize: 'Standard_D2s_v3'   // allowed + safe choice // worked or all envs and created clusters    
        osType: 'Linux'
        mode: 'System'
      }
    ]

    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
    }
  }
}
