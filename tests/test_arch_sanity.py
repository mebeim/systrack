import inspect

from systrack.arch import Arch, ARCH_CLASSES


def test_arch_subclass_method_overrides():
	# Ensure that Arch methods marked as @final aren't overridden by subclasses
	final_methods = list(filter(lambda m: hasattr(m[1], '__final__'),
		inspect.getmembers(Arch, predicate=inspect.isfunction)))

	for subclass in ARCH_CLASSES:
		for method_name, super_method in final_methods:
			if not hasattr(super_method, '__final__'):
				continue

			assert issubclass(subclass, Arch)
			assert getattr(subclass, method_name) is super_method, \
				f'{subclass.__name__} class overrides @final method ' \
				f'{method_name}() of Arch class!'
