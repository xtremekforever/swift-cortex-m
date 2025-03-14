#!/bin/bash

swift build -c release --triple armv6m-none-none-eabi --toolset Targets/Toolsets/stm32c0xx.json
