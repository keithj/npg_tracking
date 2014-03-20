#########
# Author:        Marina Gourtovaia
# Created:       17 April 2013
# copied from: svn+ssh://svn.internal.sanger.ac.uk/repos/svn/new-pipeline-dev/instrument_handling/trunk/lib/srpipe/runner/staging.pm, r17037
#

package npg_tracking::daemon::staging;

use Moose;
use Carp;
use English qw(-no_match_vars);
use Readonly;

extends 'npg_tracking::daemon';

Readonly::Scalar our $SCRIPT_NAME => q[staging_area_monitor];

override '_build_hosts' => sub {
    ##no critic (TestingAndDebugging::ProhibitNoWarnings)
    no warnings 'once';
    ##use critic
    require npg_tracking::illumina::run::folder::location;
    my @full_list = map { 'sf' . $_ . '-nfs' }
        @npg_tracking::illumina::run::folder::location::STAGING_AREAS_INDEXES;
    return \@full_list;
};
override 'command'      => sub { my ($self, $host) = @_;
                                 if (!$host) {
                                   croak q{Need host name};
                                 }
                                 my $sfarea = $self->host_to_sfarea($host);
                                 return join q[ ], $SCRIPT_NAME, q{/export/sf} . $sfarea;
                               };
override 'daemon_name'  => sub { return $SCRIPT_NAME; };

override 'log_dir' => sub { return q{}; };

override 'start' => sub { my ($self, $host) = @_;
                          my $perl5lib = q[];
                          if (defined $self->libs) {
                            $perl5lib = join q[:], @{$self->libs};
                          }
                          my $action = q[daemon -i -r -a 10 -n ] . $self->daemon_name;
                          if ($perl5lib) {
                            $action .= qq[ --env=\"PERL5LIB=$perl5lib\"];
                          }
                          if ($self->env_vars) {
                            ##no critic (Variables::ProhibitUnusedVariables)
                            while ((my $var, my $value) = each %{$self->env_vars}) {
                              $action .= qq[ --env=\"$var=$value\"];
                            }
                            ##use critic
                          }

                          my $sfarea = $self->host_to_sfarea($host);
                          my $log_dir = "/nfs/sf$sfarea/staging_daemon_logs";

                          (-e $log_dir) || croak qq[Log directory $log_dir for staging host $host does not exist];
                          (-w $log_dir) || croak qq[Log directory $log_dir for staging host $host cannot be written to];

                          my $script_call = $self->command($host);
                          my $log_path_prefix = join q[/], $log_dir, $self->daemon_name;
                          return $action . q[ --umask 002 -A 10 -L 10 -M 10 -o ] . $log_path_prefix . qq[-$host] . q[-]. $self->timestamp() . q[.log ] . qq[-- $script_call];
};

=head2 host_to_sfarea

Convert sfNN-nfs to NN

=cut
sub host_to_sfarea {
    my ($self, $host) = @_;
    if (!$host) {
      croak q{Need host name};
    }
    (my $sfarea) = $host =~ /^sf(\d+)-nfs$/smx;
    if (!$sfarea) {
      croak qq{Host name $host does not follow expected pattern sfXX-nfs};
     }
    return $sfarea;
}

no Moose;

1;
__END__

=head1 NAME

npg_tracking::daemon::staging

=head1 SYNOPSIS

=head1 DESCRIPTION

Metadata for a daemon that starts up the analysis script.

=head1 SUBROUTINES/METHODS

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=over

=item Moose

=item Carp

=item English

=item Readonly

=item npg_tracking::illumina::run::folder::location

=back

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

=head1 AUTHOR

Author: Marina Gourtovaia E<lt>mg8@sanger.ac.ukE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2013 GRL, by Marina Gourtovaia

This file is part of NPG.

NPG is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut




