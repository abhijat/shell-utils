
source colors.sh

JAVA_PROJECTS_ROOT=${HOME}/dev/java

_java_projects() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local files=(${JAVA_PROJECTS_ROOT}/*)
    COMPREPLY=( $(compgen -W "${FILES[*]##*/}" -- "$cur") )
}

gobuild() {
    PARTIAL_PATH="$1"
    if [ -z "${PARTIAL_PATH}" ]; then
        return 1
    fi

    FULL_PATH="${JAVA_PROJECTS_ROOT}/${PARTIAL_PATH}"

    test -d "${FULL_PATH}" || return 1

    printf "$BLU" "moving into ${FULL_PATH}"
    cd "${FULL_PATH}" || return 1

    printf "%s\n" "$PWD"
    printf "$BLU" "executing mvn clean install..."

    mvn clean install
}

complete -F _java_projects gobuild
