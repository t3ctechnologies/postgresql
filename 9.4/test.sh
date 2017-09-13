#!/bin/bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

echo "Testing the postgresql container"

cid="$(
	docker run -d \
	  -e DEBUG \
		--name "${NAME}" \
		"${IMAGE}"
)"
trap "docker rm -vf ${cid} > /dev/null" EXIT

postgresql() {
	docker run --rm -i \
	    -e DEBUG  \
	    -v /tmp:/mnt \
	    --link "${NAME}":"${POSTGRESQL_HOST}" \
	    "${IMAGE}" \
	    "${@}" \
	    host="${POSTGRESQL_HOST}"
}
