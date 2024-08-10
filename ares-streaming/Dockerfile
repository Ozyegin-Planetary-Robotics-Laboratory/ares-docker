FROM restreamio/gstreamer:2024-07-19T10-11-18Z-prod-dbg

COPY ./broadcast /broadcast
COPY ./receive /receive
COPY ./gst_entrypoint.bash /gst_entrypoint.bash

ENTRYPOINT [ "/gst_entrypoint.bash" ]
