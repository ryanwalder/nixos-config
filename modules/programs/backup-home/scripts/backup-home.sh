IFS=$'\n\t'

LOCK_FILE="/tmp/home-backup"

if [[ -f "${LOCK_FILE}" ]]; then
  pid=$(cat "${LOCK_FILE}")
  if ps -p "${pid}" &>/dev/null; then
    echo "$(date): Another backup process (PID: ${pid}) is already running. Exiting."
    exit 0
  else
    echo "$(date): Stale PID file found. Removing it."
    rm -f "${LOCK_FILE}"
  fi
fi

echo $$ >"${LOCK_FILE}"

cleanup() {
  rm -f "${LOCK_FILE}"
  if [[ -n "${EXCLUDE_FILE:-}" ]]; then
    rm -f "${EXCLUDE_FILE}"
  fi
  echo "$(date): Cleanup completed"
}

trap cleanup EXIT INT TERM

if ! mountpoint -q /media/backups; then
  echo "$(date): /media/backups is not mounted, aborting backup."
  exit 1
fi

EXCLUDED_DIRS=(
  ".cache"
  ".claude/cache"
  ".claude/ide"
  ".claude/locks"
  ".claude/projects"
  ".claude/shell-snapshots"
  ".claude/statsig"
  ".claude/todos"
  ".local/share/Trash"
  ".local/share/Steam"
  ".local/share/cargo"
  ".local/share/gem"
  ".local/share/lutris/runners"
  ".local/share/lutris/runtime"
  ".local/share/pipx"
  ".local/share/pnpm"
  ".local/share/vagrant"
  ".local/share/virtualenv"
  ".local/share/wineprefixes"
  ".wine"
)

EXCLUDED_FILE_PATTERNS=(
  "*.tmp"
  "*.temp"
  "*.log"
  "*~"
  "*.swp"
  "*.o"
  "*.pyc"
  "*.thumbnail"
)

EXCLUDED_DIR_PATTERNS=(
  "node_modules"
  "cache"
  "tmp"
  "logs"
  "temp"
  "__pycache__"
  "venv"
  "site-packages"
  ".gitlab-ci-local"
  "code cache"
  "thumbnails"
)

EXCLUDED_PATH_PATTERNS=(
  ".config/mozilla/firefox/*/storage"
  "compatdata/*/pfx"
  "librechat/data"
)

SOURCE_DIR="${HOME}/"
hostname=$(hostname)
OUTPUT_DIR="/media/backups/systems/${hostname}/"

mkdir --parents "${OUTPUT_DIR}"

create_exclude_file() {
  local exclude_file
  exclude_file=$(mktemp)

  {
    for dir in "${EXCLUDED_DIRS[@]}"; do
      echo "/${dir}"
      echo "/${dir^}"
      echo "/${dir^^}"
    done

    for pattern in "${EXCLUDED_FILE_PATTERNS[@]}"; do
      echo "${pattern}"
      if [[ "${pattern}" == *"."* ]]; then
        base="${pattern%.*}"
        ext="${pattern##*.}"
        echo "${base}.${ext^^}"
        echo "${base}.${ext^}"
      fi
    done

    for pattern in "${EXCLUDED_DIR_PATTERNS[@]}"; do
      echo "*/${pattern}"
      echo "*/${pattern}/"
      echo "*/${pattern}/*"
      echo "*/${pattern^}"
      echo "*/${pattern^}/"
      echo "*/${pattern^}/*"
      echo "*/${pattern^^}"
      echo "*/${pattern^^}/"
      echo "*/${pattern^^}/*"

      echo "**/*${pattern}*/**"
      echo "**/*${pattern}*"
      echo "**/*${pattern^}*/**"
      echo "**/*${pattern^}*"
      echo "**/*${pattern^^}*/**"
      echo "**/*${pattern^^}*"

      echo "${pattern}"
      echo "${pattern}/"
      echo "${pattern}/**"
      echo "${pattern^}"
      echo "${pattern^}/"
      echo "${pattern^}/**"
      echo "${pattern^^}"
      echo "${pattern^^}/"
      echo "${pattern^^}/**"
    done

    for pattern in "${EXCLUDED_PATH_PATTERNS[@]}"; do
      IFS='/' read -ra components <<<"${pattern}"

      upper_components=()
      title_components=()
      for comp in "${components[@]}"; do
        if [[ "${comp}" == "*" ]]; then
          upper_components+=("*")
          title_components+=("*")
        else
          upper_components+=("${comp^^}")
          title_components+=("${comp^}")
        fi
      done

      upper_path=$(
        IFS='/'
        echo "${upper_components[*]}"
      )
      title_path=$(
        IFS='/'
        echo "${title_components[*]}"
      )

      echo "${pattern}"
      echo "${pattern}/"
      echo "${pattern}/**"
      echo "*/${pattern}"
      echo "*/${pattern}/"
      echo "*/${pattern}/**"
      echo "**/${pattern}"
      echo "**/${pattern}/"
      echo "**/${pattern}/**"
      echo "**/${upper_path}/**"
      echo "**/${upper_path}"
      echo "**/${title_path}/**"
      echo "**/${title_path}"
    done
  } >>"${exclude_file}"

  echo "${exclude_file}"
}

EXCLUDE_FILE=$(create_exclude_file)

echo "$(date): Starting backup of ${SOURCE_DIR} to ${OUTPUT_DIR}"

rsync \
  --archive \
  --verbose \
  --human-readable \
  --delete \
  --one-file-system \
  --exclude-from="${EXCLUDE_FILE}" \
  "${SOURCE_DIR}" \
  "${OUTPUT_DIR}"

echo "$(date): Backup completed"
