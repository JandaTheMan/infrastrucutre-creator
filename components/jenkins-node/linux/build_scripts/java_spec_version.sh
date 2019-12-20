#!/usr/bin/env bash
export PATH=$PATH:/usr/local/sdkman/candidates/java/current/bin
[[ -f  ${BUILD_SCRIPTS}/Version.class ]] || printf "public class Version {\n public static void main(String[] args) {\nSystem.out.print(System.getProperty(\"java.specification.version\"));\n}\n}" > ${BUILD_SCRIPTS}/Version.java && javac ${BUILD_SCRIPTS}/Version.java
cd ${BUILD_SCRIPTS}
java Version
