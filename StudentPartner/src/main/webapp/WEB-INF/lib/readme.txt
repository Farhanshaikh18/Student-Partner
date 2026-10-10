Place your MySQL JDBC Driver jar file here:
e.g. mysql-connector-j-8.0.33.jar (or mysql-connector-java-5.1.49.jar)

In Eclipse:
Right Click on your Project -> Properties -> Java Build Path -> Libraries -> Add JARs -> select this jar.
Tomcat will automatically load JAR files placed in WebContent/WEB-INF/lib during deployment.
