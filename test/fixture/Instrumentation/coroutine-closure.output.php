<?php
/**
 * This case verifies that closures are instrumented.
 */

use Generator as Coroutine;

function () : Coroutine {
    assert(!\class_exists(\Recoil\Dev\Instrumentation\Trace::class) || ($μ = yield \Recoil\Dev\Instrumentation\Trace::install()) || true); assert(!isset($μ) || $μ->setFunction(__FILE__, __LINE__, __FUNCTION__, \func_get_args()) || true); yield 1;
    assert(!isset($μ) || $μ->setLine(__LINE__) || true); yield 2;
};
