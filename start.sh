#!/bin/bash

export MIX_ENV=prod
export PORT=4797

#!/bin/bash

source ./prod-env.sh

_build/prod/rel/time2/bin/time2 start
