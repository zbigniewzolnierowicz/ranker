import React, { FC, useMemo, useRef } from "react";
import { Box, Button, ButtonProps, Drawer, DrawerBody, DrawerCloseButton, DrawerContent, DrawerFooter, DrawerHeader, DrawerOverlay, Grid, Heading, Input, Link, useDisclosure } from '@chakra-ui/react'
import { useCookies } from "../hooks/useCookies";

interface ILogInLogOutButtonProps {
    href: string
}

const LogInLogOutButton: FC<ILogInLogOutButtonProps & ButtonProps> = ({ href, children, ...rest }) => (
    <Button as="a" colorScheme="green" href={href} w="100%" {...rest}>{children}</Button>
)

interface ILogInOutProps {
    loggedIn?: boolean 
}

const LogInOut: FC<ILogInOutProps> = ({ loggedIn }) => {
    return loggedIn
        ? (
            <LogInLogOutButton href="/auth/logout">Log out</LogInLogOutButton>
        ) : (
            <LogInLogOutButton href="/auth/github">Log in</LogInLogOutButton>
        )
}

export const Header: FC = () => {
    const cookies = useCookies()
    const { isOpen, onClose, onOpen } = useDisclosure()
    const btnRef = useRef()
    return (
        <Grid
            w="100%"
            h="fit-content"
            bg="whitesmoke"
            templateColumns="5fr 1fr"
            p={4}
            gap={4}
        >
            <Heading
                gridColumnStart="1"
                gridColumnEnd="span 1"
                textAlign="center"
            >
                Ranker
            </Heading>
            <Box
                display={['none', 'grid']}
                alignItems="center"
                justifyItems="center"
            >
                <LogInOut loggedIn={cookies.get('logged_in') === 'true'} />
            </Box>
            <Box
                display={['grid', 'none']}
                alignItems="center"
                justifyItems="center"
                gridColumn="span 1 / -1"
            >
                <Button onClick={onOpen}>MNU</Button>
            </Box>
            <Drawer
                isOpen={isOpen}
                placement="right"
                onClose={onClose}
                finalFocusRef={btnRef}
            >
                <DrawerOverlay />
                <DrawerContent>
                    <DrawerCloseButton />
                    <DrawerHeader>
                        Ranker
                    </DrawerHeader>

                    <DrawerBody>
                    </DrawerBody>

                    <DrawerFooter>
                        <LogInOut loggedIn={cookies.get('logged_in') === 'true'} />
                    </DrawerFooter>
                </DrawerContent>
            </Drawer>
        </Grid>
    )
}