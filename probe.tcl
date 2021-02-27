##database -open waves -into sim_out -default -incsize 100M
database -open waves -into sim_out -default -incsize 5G
probe -create -database waves -depth all -all -tasks -functions -memories -variables -database waves
##probe -create -database waves -depth all -all -tasks -functions -memories -variables -flow -database waves
run
status
exit
