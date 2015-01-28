rmf Cleaned;

REGISTER '/home/ivukotic/piggybank-0.14.0.jar' ;

REGISTER '/usr/lib/pig/lib/avro-*.jar';
REGISTER '/usr/lib/pig/lib/jackson-*.jar';
REGISTER '/usr/lib/pig/lib/json-*.jar';
REGISTER '/usr/lib/pig/lib/jython-*.jar';
REGISTER '/usr/lib/pig/lib/snappy-*.jar';

REGISTER 'cleanup.py' using jython as cleanfuncs;

RAW = LOAD '/user/ivukotic/IlijaCollector' as (x:chararray); 

--RAWL = LIMIT RAW 1000;
--dump RAWL;

cleaned = foreach RAW generate FLATTEN(cleanfuncs.XMLtoNTUP(x));
--dump cleaned;

sorted = order cleaned by SITE, SRC, TOS, TOD;
STORE cleaned into 'Cleaned';