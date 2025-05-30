param userPrincipalId string
param principalType string = 'User'

param storageAccountName string

// Assignments for Storage Account
// ------------------------------------------------------------------

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

// Assign the current user Storage Queue Data Contributor Role on the Storage Account resource
// to more easily view activity on the integration queues.

var storageQueueDataContributorRoleDefinitionId  = '974c5e8b-45b9-4653-ba55-5f855dd0fb88'

resource storageQueueDataContributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storageAccount.id, userPrincipalId, storageQueueDataContributorRoleDefinitionId)
  scope: storageAccount
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', storageQueueDataContributorRoleDefinitionId)
    principalId: userPrincipalId
    principalType: principalType
  }
}
