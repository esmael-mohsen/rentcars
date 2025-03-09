// ✅ Add missing repositories inside buildscript
buildscript {
    repositories {
        google()  // ✅ Ensures Firebase dependencies can be fetched
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.3.15") // ✅ Correct syntax for Kotlin DSL
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
