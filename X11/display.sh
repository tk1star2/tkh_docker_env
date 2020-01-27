#!/bin/bash

echo '#!/bin/bash' > .display
echo 'export DISPLAY='${DISPLAY} >> .display
