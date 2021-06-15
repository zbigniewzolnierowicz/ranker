import { Button, ButtonProps, ThemeTypings } from '@chakra-ui/react'
import { FC, ReactElement } from 'react'

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
      return { colorScheme: 'blue', icon: <p>go</p> }
    case 'github':
      return { colorScheme: 'blackAlpha', icon: <p>gi</p> }
    case 'logout':
      return { colorScheme: 'cyan', icon: <p>lo</p> }
    default:
      return { colorScheme: 'green', icon: <p>li</p> }
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
