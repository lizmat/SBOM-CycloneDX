role SBOM::NameDescription:ver<0.0.1>:auth<zef:lizmat> {
    has $.name;
    has $.description;

    my $lock := Lock.new;
    my %cache;

    method new(
      Str:D $name,
      Str:D $description
    --> SBOM::NameDescription:D) {
        
        # At runtime
        if $lock {
            $lock.protect: {
                %cache{$name} //= self.bless(:$name, :$description)
            }
        }

        # At compile time
        else {
            %cache{$name} := self.bless(:$name, :$description)
        }
    }

    method WHICH(SBOM::NameDescription:D:) {
        ValueObjAt.new(self.^name ~ '|' ~ $!name)
    }

    multi method Str(SBOM::NameDescription:D:) { $.name }
}

# vim: expandtab shiftwidth=4
