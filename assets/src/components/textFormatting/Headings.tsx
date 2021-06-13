import { Heading, HeadingProps } from "@chakra-ui/react";
import { FC } from "react";

export const H1: FC<HeadingProps> = ({ as: _as, fontSize: _fontSize, children, ...rest }) => (
    <Heading as="h1" fontSize="3xl">{children}</Heading>
)

export const H2: FC<HeadingProps> = ({ as: _as, fontSize: _fontSize, children, ...rest }) => (
    <Heading as="h2" fontSize="2xl">{children}</Heading>
)