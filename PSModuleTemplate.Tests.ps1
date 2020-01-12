# Pester tests, see https://github.com/Pester/Pester/wiki
$envPath = $env:Path # avoid testingc the wrong cmdlets
Import-Module (Resolve-Path ./src/*/bin/Debug/*/*.psd1) -vb
Describe 'PSModuleTemplate' {
    Context 'PSModuleTemplate module' {
        It "Given the PSModuleTemplate module, it should have a nonzero version" {
            $m = Get-Module PSModuleTemplate
            $m.Version |Should -Not -Be $null
            $m.Version.Major |Should -BeGreaterThan 0
        }
    }
    Context 'Get-Foo cmdlet' {
        It "Given a name '<Name>', '<Expected>' should be returned." -TestCases @(
            @{ Name = 'Hello, world'; Expected = 'Hello, world' }
            @{ Name = 'Zaphod'; Expected = 'Zaphod' }
        ) {
            Param($Name,$Expected)
            Get-Foo $Name |Should -BeExactly $Expected
        }
    }
}
$env:Path = $envPath
