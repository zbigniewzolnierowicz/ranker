import { Button, ButtonProps, ThemeTypings } from '@chakra-ui/react'
import { FC, ReactElement } from 'react'
import { GrGithub, GrGoogle } from 'react-icons/gr'
import { IoMdExit } from 'react-icons/io'
import { CgKeyhole } from 'react-icons/cg'

type LogInProviders = 'github' | 'google' | 'logout'

interface ILogInLogOutButtonProps {
  href: string
  provider?: LogInProviders
}

interface IProviderData {
  colorScheme: ThemeTypings['colorSchemes']
  icon: ReactElement
}

const getColorSchemeFromProvider = (provider: LogInProviders): IProviderData => {
  switch (provider) {
    case 'google':
      return { colorScheme: 'blue', icon: <GrGoogle /> }
    case 'github':
      return { colorScheme: 'blackAlpha', icon: <GrGithub /> }
    case 'logout':
      return { colorScheme: 'cyan', icon: <IoMdExit /> }
    default:
      return { colorScheme: 'green', icon: <CgKeyhole /> }
  }
}

export const LogInLogOutButton: FC<ILogInLogOutButtonProps & ButtonProps> = ({
  href,
  children: _children,
  provider,
  ...rest
}) => {
  const { icon, colorScheme } = getColorSchemeFromProvider(provider)
  return (
    <Button as="a" colorScheme={colorScheme} href={href} w="100%" {...rest}>
      {icon}
    </Button>
  )
}
