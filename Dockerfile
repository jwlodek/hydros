FROM epics-stream

RUN mkdir hydros

COPY . ./hydros/

WORKDIR /hydros

RUN sumo build use

RUN make

CMD ["./st.cmd"]

