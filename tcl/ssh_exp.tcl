#!/bin/env tclsh
# author: duanguoxue
# date: 2013-07-01
package require Expect

proc openSsh {username password address port pr } {
    global expect_out timeout spawn_id
    set timeout 60
    match_max  -d 200000
    set connFlag 0
    set ssh_str "ssh -l $username -p $port $address"
    set prompt [format "%s%s" $pr {.*(\$|%|#|>) *$}]
    #exp_internal 1
    log_user 0
    #log_file debug.logfile.log

    set processId [eval [concat exp_spawn $ssh_str] ]
    if { $spawn_id > 0 } {
        expect {
            -re {^.*ogin:\s*$} {
                exp_send "$username\r"
                exp_continue
            }
            -re {^.*assword: $} {
                exp_send "$password\r"
                exp_continue
            }
            -re {^.*remote host: Connection refused\r\n} {
                puts "connect to host $address failed"
                puts "$expect_out(buffer)"
            }
            -re {^.*connect to address .* Connection refused} {
                puts "connect to host $address failed"
                puts "$expect_out(buffer)"
                exp_send -i $spawn_id "\n"
                exp_continue
            }
            -re {^.*sure you want to continue connecting \(yes/no\)\? $} {
                exp_send "yes\r"
                exp_continue
            }
            -re $prompt {
                set connFlag 1
            }
            timeout {
                puts "Timeout occurred."
            }
            eof {
                puts "EOF occurred."
            }
        }
    }

    # Check the local connection flag, if 0 then destroy connection and exit
    if { $connFlag == 0 } {
        set errMsg "connection- to device $address. See logs for specific issue.  Shutting down connections"
        return -code error "ERROR:$errMsg"
    }

    # Set stty no echo
    set setNoEcho 0
    exp_send -i $spawn_id "stty -echo\r"
    expect {
        -i $spawn_id 
        -re $prompt {
            #puts "setting terminal with no echo."
            set setNoEcho 1
        }
        eof {
            puts "EOF occurred."
        }
        timeout {
            puts "Timeout occurred."
        }
    }

    if {$setNoEcho == 0} {
        set errMsg "Error occured during executing stty -echo."
        return -code error "ERROR:$errMsg"
    }

    set local_spawn_id $spawn_id
    set res_sp_id [list $local_spawn_id $pr]
    remoteExecute $res_sp_id "stty -onlcr"
    return $res_sp_id
}

proc closeSsh {spawnid} {
    close [lindex $spawnid 0]
}

proc remoteExecute { ssh_id cmd} {
    global expect_out timeout

    set spawnid [lindex $ssh_id 0]
    set pr [lindex $ssh_id 1]
    set sshcmd $cmd
    set prompt [format "%s%s" $pr {.*(\$|%|#|>) *$}]
    exp_send -i $spawnid "$sshcmd\r"

    # look for remote shell prompt
    set retVal ""
    expect {
        -i $spawnid 
        -re $prompt {
            append retVal $expect_out(buffer)
            set index [string last "\n" $retVal]
            set retVal [ string range $retVal 0 [expr $index - 1] ]
        }
        -re {^.*assword: $} {
            exp_send -i $spawnid "$password\r"
            exp_continue
        }
        -re {^.*sure you want to continue connecting \(yes/no\)\? $} {
            exp_send -i $spawnid "yes\r"
            exp_continue
        }
        full_buffer {
            set errMsg "full_buffer occured during exec cmd:\"$cmd\", \
                please reset matchmax according to the size of output."
            puts "$errMsg"
            return -code error $errMsg
        }
        eof -
        timeout {
            set errMsg "timeout or eof occured during exec cmd:\"$cmd\""
            puts "timeout occured during exec cmd:\"$cmd\""
            return -code error $errMsg
        }
    }

    return $retVal
}
set test_ssh_r {
# example 
# "[duanguoxue@Test ~]$" prompt is "Test"
set prompt_r "Test"
set id [openSsh duanguoxue 123456 192.168.1.112 22 $prompt_r]
set status [remoteExecute $id  "cd /root"]
set status [remoteExecute $id  "ls"]
puts "result:$status:$id"

set id2 [openSsh duanguoxue 123456 192.168.1.112 22 $prompt_r]
set status [remoteExecute $id2  "cd /root"]
set status [remoteExecute $id2  "ls"]
puts "result:$status:$id2"
set status [remoteExecute $id2  "pwd"]
puts "result:$status"

closeSsh $id
closeSsh $id2
}

#eval $test_ssh_r
