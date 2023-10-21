Jenkins.instance.getAllItems(Job.class).each { job ->
    def builds = job.getBuilds()
    if (builds.size() > 10) {
        builds.subList(10, builds.size()).each { it.delete() }
    }
}