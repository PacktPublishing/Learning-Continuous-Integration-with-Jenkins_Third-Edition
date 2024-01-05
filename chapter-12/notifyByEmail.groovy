def call(String emailRecipient) {
    switch(currentBuild.result) {
        case 'FAILURE':
            emailext (
                subject: "${currentBuild.fullDisplayName} - Build Failed",
                body: "The Jenkins job has failed. Check Jenkins for details. Job: ${env.JOB_URL}",
                to: emailRecipient
            )
            break
        case 'ABORTED':
            emailext (
                subject: "${currentBuild.fullDisplayName} - Build Aborted",
                body: "The Jenkins job was aborted. Check Jenkins for details. Job: ${env.JOB_URL}",
                to: emailRecipient
            )
            break
        case 'SUCCESS':
            emailext (
                subject: "${currentBuild.fullDisplayName} - Build Successful",
                body: "The Jenkins job completed successfully! You can view the job at: ${env.JOB_URL}",
                to: emailRecipient
            )
            break
    }
}