import { FC, useRef, ReactElement } from 'react'
import {
  Box,
  Button,
  Drawer,
  DrawerBody,
  DrawerCloseButton,
  DrawerContent,
  DrawerFooter,
  DrawerHeader,
  DrawerOverlay,
  Grid,
  Heading,
  Link,
  Stack,
  useDisclosure,
} from '@chakra-ui/react'
import { useSelector } from 'react-redux'
import { RootState } from '../store'
import { Link as RouterLink } from 'react-router-dom'
import { hideInMobile, showInMobile } from '../utils/CSSHelpers'
import { HamburgerIcon } from '@chakra-ui/icons'
import { LogInLogOutButton } from './LoginButton'

interface ILogInOutProps {
  loggedIn?: boolean
}

const LogInOut: FC<ILogInOutProps> = ({ loggedIn }) => {
  return loggedIn ? (
    <LogInLogOutButton provider="logout" href="/auth/logout" />
  ) : (
    <Stack direction="row">
      <LogInLogOutButton provider="github" href="/auth/github" />
      <LogInLogOutButton provider="google" href="/auth/google" />
    </Stack>
  )
}

const paths: { to: string; text: ReactElement | string }[] = [
  {
    to: '/me',
    text: 'Me',
  },
  {
    to: '/shop',
    text: 'Reward shop',
  },
]

export const Header: FC = () => {
  const { isOpen, onClose, onOpen } = useDisclosure()
  const btnRef = useRef()
  const loggedIn = useSelector<RootState, boolean>(state => state.user.logged_in)
  return (
    <Grid w="100%" h="fit-content" bg="whitesmoke" templateColumns="1fr 3fr 1fr" p={4} gap={4}>
      <Heading as={RouterLink} to="/" gridColumnStart="1" gridColumnEnd="span 1" textAlign="center">
        Ranker
      </Heading>
      <Box display={hideInMobile('flex')} as="nav" flexDir="row" listStyleType="none" alignItems="center">
        {loggedIn &&
          paths.map(path => (
            <Link key={path.to} as={RouterLink} to={path.to} height="fit-content" px={4}>
              {path.text}
            </Link>
          ))}
      </Box>
      <Box display={hideInMobile('grid')} alignItems="center" justifyItems="center">
        <LogInOut loggedIn={loggedIn} />
      </Box>
      <Box display={showInMobile('grid')} alignItems="center" justifyItems="center" gridColumn="span 1 / -1">
        <Button onClick={onOpen}>
          <HamburgerIcon />
        </Button>
      </Box>
      <Drawer isOpen={isOpen} placement="right" onClose={onClose} finalFocusRef={btnRef}>
        <DrawerOverlay />
        <DrawerContent>
          <DrawerCloseButton />
          <DrawerHeader>Ranker</DrawerHeader>

          <DrawerBody display="flex" flexDir="column">
            {loggedIn &&
              paths.map(path => (
                <Link
                  key={path.to}
                  as={RouterLink}
                  onClick={onClose}
                  to={path.to}
                  py={4}
                  height="fit-content"
                  width="100%"
                >
                  {path.text}
                </Link>
              ))}
          </DrawerBody>

          <DrawerFooter>
            <LogInOut loggedIn={loggedIn} />
          </DrawerFooter>
        </DrawerContent>
      </Drawer>
    </Grid>
  )
}
