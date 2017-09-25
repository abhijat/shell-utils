

source "$(dirname ${BASH_SOURCE[0]})"/colors.sh

JAVA_PROJECTS_ROOT=${HOME}/dev/java

_java_projects() {

    local cur=${COMP_WORDS[COMP_CWORD]}
    local files=( ${JAVA_PROJECTS_ROOT}/* )

    if [ ${COMP_CWORD} -eq 1 ]; then
        COMPREPLY=( $(compgen -W "${files[*]##*/}" -- "$cur") )
    elif [ ${COMP_CWORD} -eq 2 ]; then
        COMPREPLY=( $(compgen -W "git-status maven-clean-install spring-boot-run" -- "$cur") )
    fi
}

run_command() {
    CMD="$1"
    if [ -z "${CMD}" ]; then
        return
    fi

    case "${CMD}" in
        "git-status")
            printf "$GRN" "git status"
            git status
            ;;
        "maven-clean-install")
            printf "$GRN" "mvn clean install"
            mvn clean install
            ;;
        "spring-boot-run")
            printf "$GRN" "mvn spring-boot:run"
            mvn spring-boot:run
            ;;
    esac
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

    if [ -n "$2" ]; then
        run_command "$2"
    fi
}

complete -F _java_projects gobuild
